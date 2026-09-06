// The Main that starts xunit.
//
// An xunit v3 test project is an executable rather than something a separate
// runner loads, and its entry point is written during the build by an MSBuild
// task. A kata here never starts MSBuild, so the entry point has to come from
// somewhere else, and this is it: compiled into the kata's assembly alongside
// the learner's own files.
//
// The generated one has a second branch, for when the runner is asked to act
// as a test-platform server with --server or --internal-msbuild-node. Nothing
// here ever passes those, so that branch is left out rather than carried
// around unused.

internal static class XunitEntryPoint
{
    public static int Main(string[] args) =>
        global::Xunit.Runner.InProc.SystemConsole.ConsoleRunner
            .Run(args)
            .GetAwaiter()
            .GetResult();
}
