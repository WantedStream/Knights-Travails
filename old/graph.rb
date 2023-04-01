class DirectedGraphNode

    def initialize(value=nil,g=[])
        @value = value
        @graph=g;
    end

    def AddNext(g)
        @graph.push(g) if(g!=nil)
    end

    def SetValue(value)
        @value=value
    end

    def GetValue()
        return @value
    end

    def GetNexts()
        return @graph
    end



    def GetHeight(directedgn=self,v2)
        
        if(directedgn==nil)
            return 0
        end
        return GetMax(directedgn.GetNexts)+1;
    end
    def GetMax(nexts)
        max=nexts[0]
        for x in nexts do
            max=[GetHeight(x),GetHeight(max)].max
        end
        return max
    end

end