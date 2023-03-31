
require_relative './graph'

class ChessBoard

    def initialize()
        @chessboard = Array.new(8) { Array.new(8)}
     end
  
     def printboard()
      puts "CHESS BOARD:"
         @chessboard.each do |row|
            print "|"
               row.each do |value|
                  if value!=nil
                  print value.class.name[0]+"|" 
                  else
                     print "o|" 

                  end
               end
            puts ""
         end
         puts "\n\n"

     end
     def IsOutOfBounds(row,col)
        return true if(row<0||col<0||row>7||col>7)
      return false
     end

     def GetPiece(row,col)
        raise "error, out of bounds!" if(IsOutOfBounds(row,col))
        return @chessboard[row][col]
     end

     def Move(piece,row,col)
      raise "error, out of bounds!" if(IsOutOfBounds(row,col))
      raise "cant move!" if !piece.CanMove?(row,col)
        RemovePosition(piece.row,piece.col)
        SetPosition(piece,row,col)
     end


     def SetPosition(piece,row,col)
        raise "error, out of bounds!" if(IsOutOfBounds(row,col))
        @chessboard[row][col]=piece
        piece.row=row
        piece.col=col
     end
     def RemovePosition(row,col)
        raise "error, out of bounds!" if(IsOutOfBounds(row,col))
        @chessboard[row][col]=nil
     end
end

class Knight
   
   attr_accessor :row, :col
   def initialize(row,col)
      @row=row
      @col=col
   end

   def CanMove?(row,col)
      if(row==@row+2)
         return true if(col==@col+1||col==@col-1)      
      elsif(row==@row+1)
         return true if(col==@col+2||col==@col-2)
      elsif(row==@row-1)
         return true if(col==@col+2||col==@col-2)
      elsif(row==@row-2)
         return true if(col==@col+1||col==@col-1)
      end
      return false
   end 
  
   def PutAllMoveToGraph(graph,chessboard = ChessBoard.new)
      return nil if(graph==nil)


      p graph.GetValue
      chessboard.printboard
      x=gets
      graph.SetValue([@row,@col]) 
      moves = self.GetMoves
      moves.each do |movevar|
          nrow=movevar[0]
          ncol=movevar[1]
          
      if CanMove?(nrow,ncol)&&!chessboard.IsOutOfBounds(nrow,ncol)&&chessboard.GetPiece(nrow,ncol)==nil
         chessboard.SetPosition(self,nrow,ncol)
         newgraph=DirectedGraphNode.new([nrow,ncol])
         newgraph=PutAllMoveToGraph(newgraph,chessboard)
         graph.AddNext(newgraph)
         newgraph.GetNexts.each do |x|
            PutAllMoveToGraph(x,chessboard)
         end
         #@row=graph.GetValue[0]
        # @col=graph.GetValue[1]

      end


      end
         return graph
     #printGraph(graph)
   
   end 
     
   def GetMoves(row=@row,col=@col)
      return[[row+2,col+1],[row+2,col-1],[row+1,col+2],[row+1,col+2],[row-1,col+2],[row-1,col-2],[row-2,col+1],[row-2,col-1]]

   end
end

def knight_moves(pos1,pos2)
   knig=Knight.new(pos1[0],pos1[2])
   chessboard = ChessBoard.new()
   chessboard.SetPosition(knig,0,0)
    graph=knig.PutAllMoveToGraph(DirectedGraphNode.new([knig.row,knig.col]),chessboard)
   x=2
  # GetShortestPath(pos2,graph,arr)
   #return arr

end
def GetShortestPath(pos,node,totalarr,tmp=[])
   
      if(node==nil)
          tmparr.clear!
      elsif(node.GetValue[0]==pos[0]&&node.GetValue[1]==pos[1])
         tmp.push(node.GetValue)
         totalarr.push(tmp)
          tmparr.clear!
      else
         for n in node.GetNexts
         tmp.push(n.GetValue)
         GetShortestPath(pos,n,totalarr,tmp)
         end
      end
      


end
def printGraph(node)
      if(node==nil)
          tmparr.clear!
      else
         p (node.GetValue.to_s+"e")
            #node.GetNexts.each {  |n| p node printGraph(n)}
      end
      


end


knight_moves([0,1],[2,2])