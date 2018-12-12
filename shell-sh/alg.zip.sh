#!/bin/sh
ALG_DIR=/data/alg/alg_bak
ALG_DIR_PROD=/data/alg/prog

cd ${ALG_DIR}/abdomen
zip -rP linkone@2018 abdomen.zip *
cp abdomen.zip ${ALG_DIR_PROD}/abdomen

cd ${ALG_DIR}/chest
zip -rP linkone@2018   chest.zip *
cp chest.zip ${ALG_DIR_PROD}/chest

cd ${ALG_DIR}/full_body_classify
zip -rP linkone@2018 full_body_classify.zip *
cp full_body_classify.zip ${ALG_DIR_PROD}/full_body_classify

cd ${ALG_DIR}/head
zip -rP linkone@2018 head.zip *
cp head.zip ${ALG_DIR_PROD}/head

cd ${ALG_DIR}/neck
zip -rP linkone@2018 neck.zip *
cp neck.zip ${ALG_DIR_PROD}/neck

cd ${ALG_DIR}/pelvic
zip -rP linkone@2018 pelvic.zip *
cp pelvic.zip ${ALG_DIR_PROD}/pelvic

cd ${ALG_DIR}/up_body
zip -rP linkone@2018 up_body.zip *
cp up_body.zip ${ALG_DIR_PROD}/up_body
 
cp -rf /data/alg/alg_bak/lkm_contour/* /data/alg/prog/lkm_contour/
