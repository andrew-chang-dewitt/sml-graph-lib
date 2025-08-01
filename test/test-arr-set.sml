structure TestArrSet =
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

  fun test_create_from_list () =
    let
      val set = from_list ["A", "B", "C"]
      val act = length set
      val exp = 3
    in
      Assert.assertEqualInt act exp
    end

  fun test_set_to_list () =
    let
      val set = from_list ["A", "B", "C"]
      val act = to_list set
      val exp = ["A", "B", "C"]
    in
      Assert.assertEqualList Assert.assertEqualString act exp
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

  fun test_compare_equal_sets () =
    let
      val a = from_list ["A", "B", "C"]
      val b = from_list ["A", "B", "C"]
      val r = eq a b
    in
      Assert.assertTrue r
    end

  fun test_compare_not_equal_length_sets () =
    let
      val a = from_list ["A", "B", "C"]
      val b = from_list ["A", "B"]
      val r = eq a b
    in
      Assert.assertFalse r
    end

  fun test_compare_not_equal_sets () =
    let
      val a = from_list ["A", "B", "C"]
      val b = from_list ["Z", "B", "C"]
      val r = eq a b
    in
      Assert.assertFalse r
    end

  fun test_add_new_element () =
    let
      val set  = empty ()
      val set' = insert set "A"
    in
      Assert.assertEqualList Assert.assertEqualString (to_list set') ["A"]
    end

  fun test_add_existing_el () =
    let
      val set = from_list ["A", "B"]
      val set' = insert set "A"
    in
      Assert.assertEqualList Assert.assertEqualString (to_list set) (to_list set')
    end

  fun suite () =
    Test.labelTests [
      ("can create an empty set",                            test_create_empty),
      ("can create a set from list",                         test_create_from_list),
      ("can create list from set",                           test_set_to_list),
      ("a set knows if it contains some element",            test_contains),
      ("a set knows if it does not contain some element",    test_not_contains),
      ("two sets know if they're equal",                     test_compare_equal_sets),
      ("two sets of different length are not equal",         test_compare_not_equal_length_sets),
      ("two sets of same length know if they're not equal",  test_compare_not_equal_sets),
      ("sets can have new elements added",                   test_add_new_element),
      ("sets remain unchanged when adding existing element", test_add_existing_el)
    ]

end
