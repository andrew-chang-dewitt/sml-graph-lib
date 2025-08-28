structure TestGraph =
struct

  structure Assert = SMLUnit.Assert
  structure Test = SMLUnit.Test
  structure StrKey =
  struct
    type t = string

    fun eq l r = l = r
  end
  structure U = Util(ListSetFn(StrKey))
  open U

  structure K = struct
    type t = int
    fun eq l r = l = r
  end
  structure G = GraphFn(K)
  structure S = ListSetFn(K)
  open G

  fun test_empty_construct () =
    let
      val g = empty ()
    in
      Assert.assertTrue (is_empty g)
    end

  fun test_with_node_construct () =
    let
      val g = with_node 1
    in
      Assert.assertFalse (is_empty g)
    end

  fun test_nodes () =
    let
      val e  = empty ()
      val g  = with_node 1
      val g' = add_node g 2
    in
      assertEqualSet (nodes e)  [];
      assertEqualSet (nodes g)  [1];
      assertEqualSet (nodes g') [1,2]
    end

  fun test_add_edge () =
    let
      val g  = add_node (with_node 1) 2
      val g' = add_edge g 1 2
    in
      assertEqualSet

  fun suite () =
    Test.labelTests [
      ("build empty graph with constructor", test_empty_construct)
      ,("build nonempty graph with constructor", test_with_node_construct)
      ,("lists its nodes", test_nodes)
    ]
end
