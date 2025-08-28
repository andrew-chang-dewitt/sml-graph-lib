functor SetAssertions(S: SET) =
struct

  fun assertEqualSet l r =
    if (S.eq l r)
    then ()
    else raise Assert.Fail (Assert.NotEqualFailure ((toString l), (toString r)))

end
