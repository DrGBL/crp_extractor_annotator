conda activate dnanexus-env

dx login

cd /your/working/directory/path/

mkdir -p joint_called_vcfs_wes

#path here may change on dna nexus, to adjust PRN
dx generate_batch_inputs -ivcf_file='(.*).vcf.gz$' -iindex_file='(.*).vcf.gz.tbi$' --path 'HLA imputation:/Bulk/Exome sequences/Population level exome OQFE variants, pVCF format - final release/' -o 'joint_called_vcfs_wes/joint_called_vcfs_wes'

ls joint_called_vcfs_wes > list_joint_called_vcfs_wes.txt

head -n 1 joint_called_vcfs_wes/joint_called_vcfs_wes.0001.tsv | \
  sed 's/vcf_file/stage-common.vcf_file/g' | \
  sed 's/index_file/stage-common.index_file/g' > full_joint_called_vcfs_wes.txt
while read vcfs; do
  tail -n +2 joint_called_vcfs_wes/${vcfs} | grep "_c1_" >> full_joint_called_vcfs_wes.txt
done < list_joint_called_vcfs_wes.txt
