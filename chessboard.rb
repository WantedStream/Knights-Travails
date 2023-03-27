
require_relative './graph'

class ChessBoard

    def initialize()
        @chessboard = Array.new(8) { Array.new(8)}
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
  
   def PutAllMoveToGraph()
      graph = DirectedGraphNode.new()
       graph.add()
   end 
     
end
