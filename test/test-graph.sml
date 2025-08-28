structure TestGraph =
struct

  structure Assert = SMLUnit.Assert
  structure Test = SMLUnit.Test

  structure Graph = UndirectedGraph

  fun test () =
    let val actual = Graph.test 1 1
        val expected = 2
    in
      Assert.assertEqualInt actual expected
    end

  fun suite () =
    Test.labelTests [("dummy test", test)]
end
