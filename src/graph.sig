signature GRAPH =
sig

  include GRAPH_TYPES

  val empty     : unit -> graph
  val with_node : node -> graph
  val add_node  : graph -> node -> graph
  val add_nodes : graph -> node list -> graph

  val is_empty  : graph -> bool
  val nodes     : graph -> node list

end
