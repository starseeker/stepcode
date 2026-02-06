file(REMOVE_RECURSE
  "../../lib/libexpress-static.a"
  "../../lib/libexpress-static.pdb"
)

# Per-language clean rules from dependency scanning.
foreach(lang C CXX)
  include(CMakeFiles/express-static.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
