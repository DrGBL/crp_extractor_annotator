cd /project/richards/guillaume.butler-laporte/crp_wes/

pathCache=/project/richards/guillaume.butler-laporte/bin/.vep/


vep --input_file ukb_wes_all_crp.vcf.gz \
  --plugin dbNSFP,/project/richards/guillaume.butler-laporte/bin/dbSNFP4.0a_files/dbNSFP4.0a.gz,Ensembl_transcriptid,Uniprot_acc,VEP_canonical,LRT_pred,MutationTaster_pred \
  --plugin LoF,loftee_path:/project/richards/guillaume.butler-laporte/bin/.vep/Plugins/loftee/,human_ancestor_fa:/project/richards/guillaume.butler-laporte/bin/.vep/Plugins/loftee/human_ancestor.fa.gz,conservation_file:/project/richards/guillaume.butler-laporte/bin/.vep/Plugins/loftee/phylocsf_gerp.sql.gz \
  --dir_plugins /project/richards/guillaume.butler-laporte/bin/.vep/ \
  --sift b --polyphen b --humdiv b --ccds --hgvs --symbol --numbers --domains --regulatory --canonical --protein --biotype --af --af_1kg --af_esp --af_gnomade --af_gnomadg --max_af --pubmed --uniprot --mane --tsl --appris --variant_class --gene_phenotype --mirna \
  --buffer_size 100000 \
  --force_overwrite \
  --offline \
  --fork 10 \
  --dir_cache $pathCache \
  --cache --merged \
  --format vcf \
  --compress_output bgzip \
  --output_file crp_annot.vcf.gz
  
  

 
 
