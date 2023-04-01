class DirectedGraphNode
    attr_reader :value, :g

    def initialize(value=nil,g=[])
        @value = value
        @graph=g;
    end

    def AddNext(g)

        @graph.push(g) if(g!=nil&& !@graph.include?(g)&& @graph.find { |n| n.GetValue == g.GetValue }.nil?)
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

  
    def PrintGraph
        visited = []
        puts "Graph:"
        print_node(self, visited)
      end
    
      private
    
      def print_node(node, visited)
        visited << node
          puts node.GetValue[0].to_s+node.GetValue[1].to_s+": "+node.GetNexts.map{|n| n.GetValue[0].to_s+""+n.GetValue[1].to_s}.join(', ')
        node.GetNexts.each do |next_node|
          print_node(next_node, visited) unless visited.include?(next_node)
        end
      end

    def GetHeight(directedgn=self)
        
        if(directedgn==nil)
            return 0
        end
        return GetMaxHeight (directedgn.GetNexts)+1;
    end
    def GetMaxHeight (nexts)
        max = nexts[0].GetHeight
        for x in nexts do
          max = [x.GetHeight, max].max
        end
        return max
      end

end