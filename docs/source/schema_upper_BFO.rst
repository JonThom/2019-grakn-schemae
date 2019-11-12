.. _schema_upper_BFO:

.. TODO: see if we can link directly to dynamically updated link to ontologies
.. TODO: Format website to show links
.. TODO: Format code in usage correctly as code

:Author: J Thompson <jjt@tutanota.com>

====================================================
Basic Formal Ontology and Relation Ontology in Grakn
====================================================

--------
Overview
--------

Purpose
```````

To provide an upper-level ontology to underpin domain ontologies in Grakn

Description
```````````

- Basic Formal Ontology and the Relation Ontology are well established upper- level ontologies used especially in the sciences (see references)
- This schema maps BFO and select parts of RO to the Grakn hypergraph data model

Usage
`````

- `grakn server start`
- `grakn console --keyspace bfo --file <path-to-this-file>``

Now interact with the keyspace using a Grakn API, the console or Grakn workbase.
The keyspace is meant to be used as a basis for domain ontologies.

References
``````````

- BFO github wiki: https://github.com/bfo-ontology/BFO/wiki
- Relation Ontology core github wiki: https://github.com/oborel/obo-relations/wiki/ROCore

Notes
`````
:metadata: The original metadata is available in the OWL implementations
:ontology versions:
  - Basic Formal Ontology version 2.0
  - Relation Ontology 2019-02-02 release
:this doc status: alpha

------------

-------
Classes
-------

EntityType
``````````

continuant
::::::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000001
:reference: Basic Formal Ontology 2.0 Reference
:issues:
  - `Distinction between exists-at and occupies-temporal-region is unclear <https://github.com/BFO-ontology/BFO/issues/116>`_
:Grakn parent: Entity
:notes:
  - Abstract.
  - Note that BFO continuants map not only to Grakn EntityTypes, but also to AttributeTypes and roles

independent-continuant
::::::::::::::::::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000004
:reference: Basic Formal Ontology 2.0 Reference
:issues:
  - `Current definition of independent continuant would have some GDCs be independent continuants <https://github.com/BFO-ontology/BFO/issues/181>`_
  - `Remove independent continuant and specifically dependent continuant from BFO <https://github.com/BFO-ontology/BFO/issues/182>`_
:Grakn parent: `continuant`_
:notes: Abstract

immaterial entity
:::::::::::::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000141
:reference: Basic Formal Ontology 2.0 Reference
:Grakn parent: `independent-continuant`_
:notes: Abstract

continuant-fiat-boundary
::::::::::::::::::::::::

sites
:::::

spatial-region
::::::::::::::

RelationType
````````````
