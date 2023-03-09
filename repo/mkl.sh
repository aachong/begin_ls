pip3 install mkl

wget https://registrationcenter-download.intel.com/akdlm/irc_nas/19038/l_onemkl_p_2022.2.1.16993.sh

sudo sh ./l_onemkl_p_2022.2.1.16993.sh

echo '/opt/intel/oneapi/mkl/2022.2.1/lib/intel64/libmkl_rt.so'

# tvm config.cmake
# set(USE_MKL ON)
# set(BLAS_LIBRARY_MKL /home/tiger/.local/lib/libmkl_rt.so.2)
# include_directories(/opt/intel/oneapi/mkl/2022.2.1/include)
#