cwlVersion: v1.0
class: Workflow
inputs:
  inp: File
  ex: string

outputs:
  classout:
    type: File
    outputSource: compile/classfile

steps:
  untar:
    requirements:
      DockerRequirement:
        dockerPull: java:8
    run: tar-param.cwl
    in:
      tarfile: inp
      extractfile: ex
    out: [example_out]

  compile:
    run: arguments.cwl
    in:
      src: untar/example_out
    out: [classfile]
    
  wrkflow:
    run: grep-and-count.cwl
    in:
      infiles: inp
      pattern: "hello"
    out: [outfile]
