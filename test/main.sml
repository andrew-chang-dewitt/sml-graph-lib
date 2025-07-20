structure Main =
struct

  structure SMLUnit = SMLUnit

  fun main(_: string, _: string list) =
    (SMLUnit.TextUITestRunner.runTest
       {output = TextIO.stdOut}
       (TestHello.suite ());
     OS.Process.success)

  fun main' () =
    main (CommandLine.name(), CommandLine.arguments())

end
