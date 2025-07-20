structure TestHello =
struct

  structure Assert = SMLUnit.Assert
  structure Test = SMLUnit.Test
  structure Hello = SMLGraph.Hello

  fun test_hello_world () =
    let val actual = Hello.world
        val expected = "hello, world!"
    in (Assert.assertEqualString actual expected)
    end

  fun test_greet () =
    let val actual = Hello.greet "bob"
        val expected = "hello, bob!"
    in (Assert.assertEqualString actual expected)
    end

  fun test_fail () =
    Assert.assertEqualInt 1 3

  fun suite () =
    Test.labelTests [("test Hello World", test_hello_world),
                     ("test Greet",       test_greet),
                     ("test Failure",     test_fail)]

end
