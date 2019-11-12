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
The keyspace is meant to be used as a basis for domain ontologies by providing abstract classes from which sub-classes can inherit.

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
:elucidation: Continuant entities are entities which can be sliced to yield parts only along the spatial dimension.
:issues:
  - `Distinction between exists-at and occupies-temporal-region is unclear <https://github.com/BFO-ontology/BFO/issues/116>`_
:Grakn parent: entity
:Grakn notes: BFO continuants map not only to Grakn EntityTypes, but also to AttributeTypes and roles

independent-continuant
::::::::::::::::::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000004
:definition: b is an independent continuant = Def. b is a continuant which is such that there is no c and no t such that b s-depends_on c at t.
:issues:
  - `Current definition of independent continuant would have some GDCs be independent continuants <https://github.com/BFO-ontology/BFO/issues/181>`_
  - `Remove independent continuant and specifically dependent continuant from BFO <https://github.com/BFO-ontology/BFO/issues/182>`_
:Grakn parent: `continuant`_

immaterial-entity
:::::::::::::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000141
:elucidation: Immaterial entities are divided into two subgroups: boundaries and sites, which bound, or are demarcated in relation, to material entities, and which can thus change location, shape and size  and as their material hosts move or change shape or size (for example: your nasal passage; the boundary of Wales (which moves with the rotation of the Earth)
:Grakn parent: `independent-continuant`_

continuant-fiat-boundary
::::::::::::::::::::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000140
:elucidation: Basic Formal Ontology 2.0: a zero-dimensional continuant fiat boundary is a fiat point whose location is defined in relation to some material entity.
:examples: the geographic North Pole; the quadripoint where the boundaries of Colorado, Utah, New Mexico, and Arizona meet
:Grakn parent: `immaterial-entity`_

zero-dimensional-continuant-fiat-boundary
:::::::::::::::::::::::::::::::::::::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000147
:Grakn parent: `continuant-fiat-boundary`_

one-dimensional-continuant-fiat-boundary
::::::::::::::::::::::::::::::::::::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000142
:reference: Basic Formal Ontology 2.0 Reference
:Grakn parent: `continuant-fiat-boundary`_

two-dimensional-continuant-fiat-boundary
::::::::::::::::::::::::::::::::::::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000146
:reference: Basic Formal Ontology 2.0 Reference
:Grakn parent: `continuant-fiat-boundary`_

site
::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000029
:examples: the interior of an egg, the environment of a cow
:issues:
  - `a site occupant is located_in a site <https://github.com/BFO-ontology/BFO/issues/36>`_
:Grakn parent: `immaterial-entity`_

spatial-region
::::::::::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000006
:note: We recommend that users of BFO region terms specify the coordinate frame in terms of which their spatial and temporal data are represented.
:examples: When dealing with spatial regions on the surface of the Earth, for example, this will be the coordinate frame of latitude and longitude, potentially supplemented by the dimension of altitude. Lines of latitude and longitude  are two-dimensional continuant fiat boundaries which move as the planet  rotates and as it moves in orbiting the sun; however, they are by definition at rest relative to the coordinate frame which they determine.
:Grakn parent: `immaterial-entity`_

material-entity
:::::::::::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000040
:elucidation: A material entity is an independent continuant that has some portion of matter as proper or improper continuant part. Material entities (continuants) can preserve their identity even while gaining and losing material parts. Every material entity is localized and can move in space. Material entities are concretized specifically-dependent-continuants.
:examples: a photon, a human being
:note: The BFO user's guide document emphasises that Object, Fiat Object Part and Object Aggregate are not intended to be exhaustive of Material Entity
:Grakn parent: `independent-continuant`_

object
::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000030
:elucidation: an object is a maximal causally unified material entit. It offers three paradigms of causal unity: (1) cells, proteins, molecules (2) solid portions of matter (3) engineered artefacts
:examples: a photon, a human being
:Grakn parent: `material-entity`_

fiat-object-part
::::::::::::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000024
:examples: the wall of the cervical and abdominal parts of the esophagus
:notes: in the `diagram <http://ontology.buffalo.edu/bfo/BFO2.png>`_  this is just called fiat object but in the BFO 2.0 user's guide it is referred to as fiat object part
:Grakn parent: `material-entity`_

object-aggregate
::::::::::::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000027
:examples: organisms, populations, organizations, institutions
:issues:
  - `on aggregates of spatial regions <https://github.com/BFO-ontology/BFO/issues/211>`_
  - `on parts of members of object aggregates <https://github.com/BFO-ontology/BFO/issues/161>`_
:Grakn parent: `material-entity`_

generically-dependent-continuant
::::::::::::::::::::::::::::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000031
:elucidation: A generically dependent continuant is a replicable, portable patterns which is concretized as a specifically dependent continuant in an independent continuants.
:examples: Beethoven's ninth symphony, a chess board pattern.
:issues:
  - `difference between a GDC and SDC and need for GDC - SDC - IDC chain (some see SDC as superfluous) <https://github.com/BFO-ontology/BFO/issues/10>`_
:Grakn parent: `continuant`_


specifically-dependent-continuant
::::::::::::::::::::::::::::::::

:ontology: Basic Formal Ontology v2.0
:source: `BFO 2.0 OWL <https://raw.githubusercontent.com/BFO-ontology/BFO/v2.0/bfo.owl>`_
:purl: http://purl.obolibrary.org/obo/BFO_0000020
:elucidation: a specifically-dependent-continuant is a concretization of some generically dependent continuant pattern. The SDC depends for its existence on the independent continuant in which it inheres
:examples: a smile, the black and white colouring on a chess board
:Grakn notes: Some BFO one-sided specifically-dependent-continuants (e.g. qualities) map to Grakn attributes, but others (e.g. this specific novel which  specifically depends on its concretization on the ink and paper with which it is printed) map to Grakn EntityTypes, others to roles or relations. Only a few cases, such as a realization of a disease, call for this EntityType to be used.
:Grakn parent: `continuant`_
