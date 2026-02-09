# AP242 styled_item Test

## Purpose

This test validates that the STEPcode-generated C++ code from the AP242 schema can correctly handle `styled_item` entities, particularly the TREAT expression in the WR3 WHERE rule that was problematic in the original schema.

## Background

The AP242 schema contains a `styled_item` entity with a complex WHERE rule (WR3) that uses the TREAT expression for type narrowing:

```express
ENTITY styled_item
  SUBTYPE OF (representation_item);
  styles : SET [0 : ?] OF presentation_style_assignment;
  item   : styled_item_target;
WHERE
  WR3: ('AP242_MANAGED_MODEL_BASED_3D_ENGINEERING_MIM_LF.MAPPED_ITEM' IN TYPEOF(item)) OR
       ('AP242_MANAGED_MODEL_BASED_3D_ENGINEERING_MIM_LF.GEOMETRIC_REPRESENTATION_ITEM' IN TYPEOF(item)) OR
       (('AP242_MANAGED_MODEL_BASED_3D_ENGINEERING_MIM_LF.SET_REPRESENTATION_ITEM' IN TYPEOF(item)) AND
        (SIZEOF(QUERY(it
                      <* TREAT(item AS set_representation_item)
                      | NOT (('AP242_MANAGED_MODEL_BASED_3D_ENGINEERING_MIM_LF.MAPPED_ITEM' IN TYPEOF(it)) OR
                             ('AP242_MANAGED_MODEL_BASED_3D_ENGINEERING_MIM_LF.GEOMETRIC_REPRESENTATION_ITEM' IN
                              TYPEOF(it))))) =
         0));
END_ENTITY;
```

The TREAT expression `TREAT(item AS set_representation_item)` performs explicit type narrowing from a SELECT type to a specific aggregate type.

## Test Files

- `test_ap242_styled_item.stp` - Minimal AP242 STEP file containing styled_item instances
- `test/cpp/schema_specific/ap242_styled_item.cc` - C++ test program

## Test Implementation

The test:
1. Reads an AP242 STEP file containing styled_item entities
2. Parses it using the generated libsdai_ap242.so library
3. Verifies that styled_item instances are correctly parsed and accessible
4. Validates the entity relationships and attributes

## Running the Test

```bash
# Build the AP242 schema and test
cd build
ninja sdai_ap242treat
ninja tst_ap242_styled_item

# Run the test
./bin/tst_ap242_styled_item ../test/p21/test_ap242_styled_item.stp
```

Or via CTest:
```bash
ctest -R ap242_styled_item -V
```

## Success Criteria

- The STEP file parses without errors
- styled_item entities are found and accessible
- The generated C++ code correctly handles the TREAT expression in WR3
- No crashes or segmentation faults occur

## Related Documentation

- `data/ap242treat/README.md` - AP242 TREAT schema documentation
- `doc/ap242-comparison.md` - Comparison of flow-sensitive narrowing vs TREAT
- Problem statement: ENTITY styled_item with TREAT expression support
