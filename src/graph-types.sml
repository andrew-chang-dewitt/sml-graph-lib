functor GraphTypes (A: sig
                         type 'a graph
                         structure Node: NODE
                       end): GRAPH_TYPES =
struct

  type node = A.Node.t
  type 'a graph = 'a A.graph
  type 'a adj = 'a * node list
  type 'a context = node list * node * 'a * node list

end
