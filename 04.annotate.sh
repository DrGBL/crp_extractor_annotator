cd /your/working/directory/

pathCache=/path/to/.vep/
pathPlugin=/path/to/.vep/Plugins/
pathdbNSFP=/path/to/dbNSFP4.3a/
pathFasta=/path/to/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
pathLoftee=/path/to/loftee/plugin/files/ #note that this is the loftee grch38 branch


vep --input_file ukb_wes_all_crp_for_annot.vcf.gz \
  --plugin dbNSFP,${pathdbNSFP}dbNSFP4.3a_grch38.gz,Ensembl_transcriptid,LRT_pred,MutationTaster_pred,CADD_raw,CADD_raw_rankscore,CADD_phred,Polyphen2_HDIV_score,Polyphen2_HDIV_rankscore,Polyphen2_HDIV_pred,Polyphen2_HVAR_score,Polyphen2_HVAR_rankscore,Polyphen2_HVAR_pred \
  --plugin LoF,loftee_path:${pathLoftee},human_ancestor_fa:${pathLoftee}human_ancestor.fa.gz \
  --dir_plugins ${pathPlugin} \
  --sift b --ccds --hgvs --symbol --numbers --domains --regulatory --canonical --protein --biotype --af --af_1kg --af_gnomade --af_gnomadg --max_af --pubmed --uniprot --mane --tsl --appris --variant_class --gene_phenotype --mirna \
  --buffer_size 5000 \
  --force_overwrite \
  --offline \
  --dir_cache $pathCache \
  --fasta ${pathFasta} \
  --cache --merged \
  --compress_output bgzip \
  --output_file crp_annot.gz

  
  

 
 
