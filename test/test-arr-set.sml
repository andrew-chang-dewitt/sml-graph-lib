structure TestListSet =
struct

  structure Assert = SMLUnit.Assert
  structure Test = SMLUnit.Test
  structure StrSet = ListSetFn(struct type t = string; val compare = String.compare end)
  open StrSet

  fun test_create_constructor () =
  let
    val aset: set = Set ["A"]
    val (Set act) = aset
    val exp = ["A"]
  in
    Assert.assertEqualList Assert.assertEqualString act exp
  end

  fun test_create_empty () =
    let
      val set = empty ()
      val act = length set
      val exp = 0
    in
      Assert.assertEqualInt act exp
    end

  fun test_is_empty () =
    let
      val set = empty ()
    in
      Assert.assertTrue (is_empty set)
    end

  fun test_is_not_empty () =
    let
      val set = Set ["A"]
    in
      Assert.assertFalse (is_empty set)
    end

  fun test_create_from_list () =
    let
      val set = from_list ["A", "B", "C"]
      val act = length set
      val exp = 3
    in
      Assert.assertEqualInt act exp
    end

  fun test_contains () =
    let
      val set = from_list ["A", "B", "C"]
      val has_A = contains set "A"
    in
      Assert.assertTrue has_A
    end

  fun test_not_contains () =
    let
      val set = from_list ["A", "B", "C"]
      val has_Z = contains set "Z"
    in
      Assert.assertFalse has_Z
    end

  fun test_set_equality () =
    let
      val a = from_list ["A", "B", "C"]
      val b = from_list ["A", "B"]
      val z = from_list ["Z", "B", "C"]
    in
      Assert.assertTrue  (eq a a);
      Assert.assertFalse (eq a b);
      Assert.assertFalse (eq a z)
    end

  fun test_set_equality_unordered () =
    let
      val a = from_list ["A", "B", "C"]
      val b = from_list ["B", "A", "C"]
    in
      Assert.assertTrue  (eq a b)
    end

  fun toString (Set s: set): string =
    let
      fun f []      = ""
        | f [x]     = x
        | f (x::xs) = x ^ ", " ^ (f xs)
    in
      "{ " ^ (f s) ^ " }"
    end

  fun assertEqualSet l r =
    if (eq l r)
    then ()
    else raise Assert.Fail (Assert.NotEqualFailure ((toString l), (toString r)))

  fun test_custom_assert () =
    assertEqualSet (from_list ["A", "B"]) (from_list ["B", "A"])

  fun test_set_to_list () =
    let
      val set = from_list ["A", "B", "C"]
      val act = to_list set
      val exp = ["A", "B", "C"]
    in
      Assert.assertEqualList Assert.assertEqualString act exp
    end

  fun test_add_new_element () =
    let
      val set  = empty ()
      val set' = insert set "A"
    in
      assertEqualSet set' (from_list ["A"])
    end

  fun test_add_existing_el () =
    let
      val set = from_list ["A", "B"]
      val set' = insert set "A"
    in
      assertEqualSet set set'
    end

  fun suite () =
    Test.labelTests [
      ("can create set using constructor",                           
       test_create_constructor)
      ,("can create an empty set",                           
       test_create_empty)
      ,("a set knows if it is empty",           
       test_is_empty)
      ,("a set knows if it is not empty",           
       test_is_not_empty)
      ,("can create a set from list",                        
       test_create_from_list)
      ,("a set knows if it contains some element",           
       test_contains)
      ,("a set knows if it does not contain some element",   
       test_not_contains)
      ,("sets can have equality",                    
       test_set_equality)
      ,("set equality is order independant",                    
       test_set_equality_unordered)
      ,("test custom assert",                    
       test_custom_assert)
      ,("can create list from set",                          
       test_set_to_list)
      ,("sets can have new elements added",                  
       test_add_new_element)
      ,("sets remain unchanged when adding existing element",
       test_add_existing_el)
    ]

end
