structure TestGraph =
struct

  structure Assert = SMLUnit.Assert
  structure Test = SMLUnit.Test

  structure Args: GRAPH_ARGS =
  struct
    structure Node = struct type t = int end
  end
  structure Graph = Graph (Args)

  fun testEmpty () =
    let val actual = Graph.empty
    in Assert.assertTrue (Graph.isEmpty actual)
    end

  fun testNodes () =
      (*
    let val actual = Graph.nodes test_graph
       *)
    let val actual = [2,3,1,4]
        val expected = [1,2,3,4]
    in Assert.assertEqualIntList actual expected
    end

  fun suite () =
    Test.labelTests [
      ("knows if it is empty", testEmpty),
      ("lists it's nodes", testNodes)
    ]
end
