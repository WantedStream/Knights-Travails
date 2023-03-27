class DirectedGraphNode

    def initialize(value,g)
        @value = value
        @graph=[g];
    end
    def initialize(value)
        @value = value
        @graph=[];
    end
    def AddNext(g)
        @graph.push(g)
    end

    def SetValue(value)
        @value=value
    end
end