cd /your/working/directory/

ls hla_fetch_all_crp_wes/ | \
  grep -v workflow | \
  sed 's|$|/ukb_wgs_mhc.vcf.gz|g' | \
  sed 's|^|/your/working/directory/hla_fetch_all_crp_wes/|g' > list_to_concat.txt

bcftools concat --file-list list_to_concat.txt -Ou | \
  bcftools sort -Oz > ukb_wes_all_crp.vcf.gz
tabix -p vcf ukb_wes_all_crp.vcf.gz
