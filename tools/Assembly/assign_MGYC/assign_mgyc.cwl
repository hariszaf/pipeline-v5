#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: "Assign MGYC to DNA contigs"

requirements:
  ResourceRequirement:
    ramMin: 300
  InlineJavascriptRequirement: {}

inputs:
  input_fasta:
    type: File
    inputBinding:
      prefix: -f
  mapping:
    type: string
    inputBinding:
      prefix: -m
  count:
    type: int
    inputBinding:
      prefix: -c
  accession:
    type: string
    inputBinding:
      prefix: -a

baseCommand: [ assign_mgyc.py ]

outputs:
  renamed_contigs_fasta:
    type: File
    format: edam:format_1929
    outputBinding:
      glob: "*mgyc.fasta"
      outputEval: |
        ${
          self[0].basename = inputs.input_fasta.basename;
          return self[0]
        }

hints:
  - class: DockerRequirement
    dockerPull: 'alpine:3.7'

$namespaces:
 edam: http://edamontology.org/
 s: http://schema.org/
$schemas:
 - http://edamontology.org/EDAM_1.16.owl
 - https://schema.org/version/latest/schemaorg-current-http.rdf

s:license: "https://www.apache.org/licenses/LICENSE-2.0"
s:copyrightHolder: "EMBL - European Bioinformatics Institute"
