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
        RemovePosition(piece.positionX,piece.positionY)
        SetPosition(piece,row,col)
     end
     def SetPosition(piece,row,col)
        raise "error, out of bounds!" if(IsOutOfBounds(row,col))
        @chessboard[row][col]=piece
     end
     def RemovePosition(row,col)
        raise "error, out of bounds!" if(IsOutOfBounds(row,col))
        @chessboard[row][col]=nil
     end
end

cs = ChessBoard.new()
p cs.GetPiece(0,0)
cs.SetPosition("knight",0,0)
p cs.GetPiece(0,0)
