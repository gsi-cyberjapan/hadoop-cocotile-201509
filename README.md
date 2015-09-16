# hadoop-cocotile-201509
a set of programs to generate cocotile from the collection of mokuroku

# Prerequistite
1. You need to have access to layers_txt and xyz directories of maps.gsi.go.jp, downloaded or mapped. In generate_input.rb, that directory is set as /Users/hfu/htdocs/.
2. If you have additional layers not yet released, you need to have access to a directory which contains layers.txt for these layers. In generate_input.rb, that directory is set as ./layers_txt.


# How to use
## Generate input for hadoop
```sh
$ ruby generate_input.rb | gzip -9 > input/input.gz
```
will prepare input from the bunch of mokuroku.csv.gz whose location is identified from a bunch of layers.txt.

## Run hadoop
```sh
$ hadoop jar /usr/local/Cellar/hadoop/2.6.0/libexec/share/hadoop/tools/lib/hadoop-streaming-2.6.0.jar -input input -output output -mapper cat -reducer reduce.rb
```
will generate output files in output folder. Normally the name of the file is part-00000.

## Upload hadoop output
Upload the output (part-00000) to the server.

## Generate cocotile tiles from the hadoop output
Run distill.rb to generate cocotile from the hadoop output:
```sh
$ ruby distill.rb
```
If you have other output than part-00000, you need to change distill.rb slightly.

# See also
- http://github.com/gsi-cyberjapan/cocotile-spec
- http://github.com/gsi-cyberjapan/mokuroku-spec
- http://github.com/mapbox/serialtiles-spec: the format of the hadoop output is inspired by serialtiles-spec.
