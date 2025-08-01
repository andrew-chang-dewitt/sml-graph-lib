structure Main =
struct

  structure Test = SMLUnit.Test
  structure TextUITestRunner = SMLUnit.TextUITestRunner

  fun main(_: string, _: string list) =
    let
      val tests = Test.TestList [
         (*
         Test.TestLabel("Graph", TestGraph.suite ()),
          *)
         Test.TestLabel("ListSet", TestListSet.suite ())
      ]
    in
      (TextUITestRunner.runTest
         {output = TextIO.stdOut}
         tests;
       OS.Process.success)
    end

  fun main' () =
    main (CommandLine.name(), CommandLine.arguments())

end
