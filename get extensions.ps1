$a = dir d:\_AllPhotos -File -Recurse | select -expand Extension | sort -Unique

$a