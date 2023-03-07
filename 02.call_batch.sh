# dx login if needed

cd /your/working/directory

dx rm -r /hla_fetch_all_crp_workflow/
java -jar dxCompiler-2.5.0.jar compile extract_crp.wdl -project 'HLA imputation' -folder /hla_fetch_all_crp_workflow/

dx rm -r /hla_fetch_all_crp_wes/
dx run /hla_fetch_all_crp_workflow/crp_fetch \
  --batch-tsv full_joint_called_vcfs_wes.txt \
  -istage-common.ref_genome="GRCh38_full_analysis_set_plus_decoy_hla.fa.gz" \
  -istage-common.ref_genome_index="GRCh38_full_analysis_set_plus_decoy_hla.fa.gz.fai" \
  -istage-common.ref_genome_gzi="GRCh38_full_analysis_set_plus_decoy_hla.fa.gz.gzi" \
  --priority low \
  --batch-folders \
  --destination=/hla_fetch_all_crp_wes/

rm -r hla_fetch_all_crp_wes/
dx download -r --overwrite /hla_fetch_all_crp_wes/




