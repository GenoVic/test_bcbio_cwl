$namespaces:
  arv: http://arvados.org/cwl#
arguments:
- position: 0
  valueFrom: sentinel_runtime=cores,$(runtime['cores']),ram,$(runtime['ram'])
- sentinel_parallel=batch-merge
- sentinel_outputs=vrn_file
- sentinel_inputs=batch_rec:record,region_block:var,vrn_file_region:var
baseCommand:
- bcbio_nextgen.py
- runfn
- concat_batch_variantcalls
- cwl
class: CommandLineTool
cwlVersion: v1.0
hints:
- class: DockerRequirement
  dockerImageId: quay.io/bcbio/bcbio-vc
  dockerPull: quay.io/bcbio/bcbio-vc
- class: ResourceRequirement
  coresMin: 1
  outdirMin: 1029
  ramMin: 2048
  tmpdirMin: 3
- class: SoftwareRequirement
  packages:
  - package: bcftools
    specs:
    - https://anaconda.org/bioconda/bcftools
  - package: htslib
    specs:
    - https://anaconda.org/bioconda/htslib
  - package: gatk4
    specs:
    - https://anaconda.org/bioconda/gatk4
- class: arv:APIRequirement
inputs:
- id: batch_rec
  type:
    items:
      fields:
      - name: description
        type: string
      - name: resources
        type: string
      - name: config__algorithm__validate
        type:
        - File
        - 'null'
        - string
      - name: reference__fasta__base
        type: File
      - name: config__algorithm__variantcaller
        type:
        - string
        - 'null'
      - name: config__algorithm__coverage_interval
        type:
        - string
        - 'null'
      - name: metadata__batch
        type: string
      - name: metadata__phenotype
        type: string
      - name: reference__twobit
        type: File
      - name: reference__snpeff__hg19
        type: File
      - name: config__algorithm__validate_regions
        type:
        - 'null'
        - string
        - File
      - name: genome_build
        type: string
      - name: genome_resources__aliases__human
        type:
        - string
        - 'null'
        - boolean
      - name: config__algorithm__tools_off
        type:
        - 'null'
        - string
        - items: string
          type: array
      - name: genome_resources__variation__dbsnp
        type: File
      - name: vrn_file
        type:
        - File
        - 'null'
        - string
      - name: genome_resources__variation__cosmic
        type: File
      - name: reference__genome_context
        type:
          items: File
          type: array
      - name: analysis
        type: string
      - name: config__algorithm__tools_on
        type:
        - 'null'
        - string
        - items: string
          type: array
      - name: config__algorithm__variant_regions
        type:
        - File
        - 'null'
      - name: genome_resources__aliases__ensembl
        type: string
      - name: reference__rtg
        type: File
      - name: genome_resources__aliases__snpeff
        type: string
      - name: align_bam
        type:
        - File
        - 'null'
      - name: regions__sample_callable
        type:
        - File
        - 'null'
      - name: config__algorithm__callable_regions
        type: File
      name: batch_rec
      type: record
    type: array
- id: region_block
  type:
    items:
      items: string
      type: array
    type: array
- id: vrn_file_region
  secondaryFiles:
  - .tbi
  type:
    items:
    - File
    - 'null'
    type: array
outputs:
- id: vrn_file
  secondaryFiles:
  - .tbi
  type: File
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entry: $(JSON.stringify(inputs))
    entryname: cwl.inputs.json
