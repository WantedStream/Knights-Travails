
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

   def CanMove?(row,col,currentcol,currentrow)
      if(row==currentrow+2)
         return true if(col==currentcol+1||col==currentcol-1)      
      elsif(row==currentrow+1)
         return true if(col==currentcol+2||col==currentcol-2)
      elsif(row==currentrow-1)
         return true if(col==currentcol+2||col==currentcol-2)
      elsif(row==currentrow-2)
         return true if(col==currentcol+1||col==currentcol-1)
      end
      return false
   end 

   def PutAllMoveToGraph2(node, chessboard = ChessBoard.new)
         return nil if node.nil? # nothing to do if there is no node or root to begin the search
         queue = Queue.new
         queue.enq(node)
         result = nil
         while !queue.empty?
           n = queue.deq


           moves = self.GetMoves
           moves.each do |movevar|
            nrow=movevar[0]
            ncol=movevar[1]
            if CanMove?(nrow, ncol) && !chessboard.IsOutOfBounds(nrow, ncol) && chessboard.GetPiece(nrow, ncol) == nil
               chessboard.SetPosition(self, nrow, ncol)
              queue.enq(n)
            end
           end


         end
       
         node # returns node found in BST else default value nil
       
    end
   def PutAllMoveToGraph(graph, chessboard = ChessBoard.new)
      return nil if (graph == nil)
    

     # chessboard.printboard
     # x=gets
      graph.SetValue([@row, @col])
      moves = self.GetMoves
      moves.each do |movevar|
        nrow = movevar[0]
        ncol = movevar[1]
        newgraph=nil

    

        


        if CanMove?(nrow, ncol,graph.GetValue[0],graph.GetValue[1]) && !chessboard.IsOutOfBounds(nrow, ncol) && chessboard.GetPiece(nrow, ncol) == nil 
          chessboard.SetPosition(self, nrow, ncol)
          newgraph = DirectedGraphNode.new([nrow, ncol])
          newgraph = self.PutAllMoveToGraph(newgraph, chessboard)
          graph.AddNext(newgraph)
         chessboard.RemovePosition(nrow, ncol)
            
        end

       
      end
    #  chessboard.printboard
     # x=gets

      

      #chessboard.printboard
     # chessboard.printboard

      return graph


    end


   def GetMoves(row=@row,col=@col)
      return[[row+2,col+1],[row+2,col-1],[row+1,col+2],[row+1,col-2],[row-1,col+2],[row-1,col-2],[row-2,col+1],[row-2,col-1]]

   end
end

def knight_moves(pos1,pos2)
   knig=Knight.new(pos1[0],pos1[1])
   chessboard = ChessBoard.new()
   chessboard.SetPosition(knig,pos1[0],pos1[1])
    graph=knig.PutAllMoveToGraph(DirectedGraphNode.new([pos1[0],pos1[1]]),chessboard)
   x=2
   arr=[]
   paths = GetPaths(pos2,graph,arr)
    arr=  paths .reduce{ |prev, current| current.length <= prev.length ? current : prev  } 
    puts "you made it in "+(arr.length-1).to_s+" moves! Here is your path:"
      arr.each{|x| p x}
end



def GetPaths(pos, node, paths=[], path=[])
  if node.nil?
    return paths
  elsif node.GetValue == pos
    path.push(node.GetValue)
    paths.push(path.dup)
    path.pop
    return paths
  else
    node.GetNexts.each do |n|
      path.push(node.GetValue)
      GetPaths(pos, n, paths, path)
      path.pop
    end
  end
  return paths
end





 knight_moves([0,0],[1,2])
 knight_moves([0,0],[3,3])
 knight_moves([3,3],[0,0])
  knight_moves([3,3],[4,3])
