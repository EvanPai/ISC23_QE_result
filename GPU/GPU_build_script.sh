#!/bin/bash

HOST=PSC
MPI=ompi

QE_RELEASE_PACK=$PWD/qe-7.1-ReleasePack.tar.gz
QE_INS_DIR=$PWD/builds/qe-7.1-$HOST-$MPI-O3-with-scalapack-21.9

mkdir -p $QE_INS_DIR

# openmpi
module load openmpi/4.0.5-nvhpc22.9

CFLAGS="-O3"
FCFLAGS="-O3"
COMP="CC=mpicc CXX=mpicxx FC=mpifort F90=mpifort MPIF90=mpifort"

# check the existence of QE_RELEASE_DIR
if test -f "$QE_RELEASE_PACK"; then
    # if exist, build!
    # echo "Extracting $QE_RELEASE_PACK"
    # tar xvf $QE_RELEASE_PACK
    cd qe-7.1

    # choose the proper MPI packages
    ./configure --prefix=$QE_INS_DIR \
            --with-cuda=$NVHPC_CUDA_HOME \
            --with-cuda-cc=70 \
            --with-cuda-runtime=11.7 \
            --with-cuda-mpi=no \
            --with-scalapack=yes \
            CFLAGS="$CFLAGS" \
            FCFLAGS="$FCFLAGS" \
            $COMP

    make clean
    make -j 160 cp pw
    make install

    cp ../$0 $QE_INS_DIR/

else
    echo "Remember to get qe software stack from [qe-download](https://www.quantum-espresso.org/download-page/) to this repository, before everything starts."
fi

