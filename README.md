# Rendering arbitrary geometry collections from postgis

## Overview

Mapnik uses flexible data structures for storing features
and their geometries. It also supports rendering rules
to allow multiple styles be applied to a given layer.

If you have a postgis table with a single geometry column
but many different kinds of geometry types, it is easy to
render directly from this column. You just need to apply
the desired styling logic and rules to display your data in
reasonable ways.

This repo includes a test XML and sample data to experiment
with this flexibility and brainstorm ways to make it better.


## Setup

    createdb -T template_postgis geometries
    psql geometries -f load_geoms.sql


## Testing renders

Edit the 'postgis.xml' adding or removing styles you wish to view rendered.

Then render the map out:

    nik2img.py postgis.xml image.png


## Details of data structures

* Mapnik feature objects can store one or many geometries, each of arbitrary type.

* Mapnik geometry objects can store single or multipart points, lines, or polygons

* Some Mapnik datasources can enhance this flexibility by parsing OGC multigeometries
  into a sequence of single geometries on a features: basically flattening OGC multigeometries
  into a list of single geometries.

* Mapnik symbolizers can be applied to features with arbitrary types of geometries

* Mapnik renderers (agg, grid and cairo) are responsible for handling the drawing of
  a given feature with applied symbolizer. Different rendering behaviors are triggered for certain
  symbolizers at the rendering level depending on the `placement` type and/or the geometry type.
  
  For example, common uses where this flexibility makes life simple:
  
    - LineSymbolizer:
       applied to a linestring geometry it strokes lines
       applied to a polygon geometry it strokes the perimeter (outline)
    
    - PolygonSymbolizer:
       applied to a polygon geometry it fills the polygon(s)
  
  But be aware this flexibility also creates some ambiguity or does nothing in some cases:
  
    - PolygonSymbolizer:
       lines - draws unfilled polygons and looks pretty odd
       point - does nothing

    - LineSymbolizer:
       point - does nothing

  And depending on `placement` type (and the types default, which can depend on geometry type)
  you can see some complex behaviors:
  
    - MarkersSymbolizer:
       polygon geometry - draws point at centroid of each polygon (placement=point)
       polygon geometry - draws point along the outline of each polygon (placement=line)
       point geometry - draws point no matter the value of placement

## Caveats

* The mapnik postgis plugin accepts an option called `multiple_geometries`, which if true
  (default is false) triggers flattening of multigeometries into single paths during
  wkb parsing. This is needed for various renderers in mapnik to cope better with multi-geometries.
  For example, without it MarkersSymbolizer will only draw the first polygon and mapnik's centroid
  algorithm will produce bogus results for multipolygon labels.
  
* TextSymbolizer - labeling centroids of multipolygons does not work properly
* MarkersSymbolizer on multipolygons only draws first point unless geometries are flattened

Bugs around multigeometry support are tracked via:

    https://github.com/mapnik/mapnik/issues?sort=created&labels=multigeom+robustness&direction=desc&state=open
