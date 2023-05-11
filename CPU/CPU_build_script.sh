#going to a directory that you want to install QE
## EvanPai
#download QE

git clone https://github.com/EvanPai/ISC23-QE.git
cd ISC23-QE
export BUILD_PATH=$PWD

source ${HOME}/.bashrc
#clean the folder
mkdir build
mv CP-W256.zip build
mv supercell_11layer.zip build
mv qe-7.1-ReleasePack.tar.gz build
mv hpcx-2.13.1.tbz build

cd ${BUILD_PATH}/build 
tar xjfp hpcx-2.13.1.tbz

cd ${BUILD_PATH}
mkdir opt
mv build/hpcx-2.13.1 opt

#use hpcx module
module use ${BUILD_PATH}/opt/hpcx-2.13.1/modulefiles #append this line into ~/.bashrc

#unzip the testcases
cd ${BUILD_PATH}/build
unzip CP-W256.zip
unzip supercell_11layer.zip

mv CP-W256 ${BUILD_PATH}
mv supercell_11layer ${BUILD_PATH}

#compile qe-7.1
tar xfp qe-7.1-ReleasePack.tar.gz
cd qe-7.1

#use icc + hpcx 
source /jet/packages/intel/oneapi/compiler/2022.1.0/env/vars.sh
source /jet/packages/intel/oneapi/mkl/2022.1.0/env/vars.sh

module load hpcx

export OMPI_MPICC=icc
export OMPI_MPICXX=icpc
export OMPI_MPIFC=ifort
export OMPI_MPIF90=ifort
COMP="CC=mpicc CXX=mpicxx FC=mpif90 F90=mpif90"

INSDIR=${BUILD_PATH}

./configure --enable-parallel --prefix=$INSDIR --enable-openmp CFLAGS="  -O3 " FCFLAGS=" -O3 " F90FLAGS="-O3 " $COMP

make -j 32 cp pw 
make install


cd ${BUILD_PATH}


