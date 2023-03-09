cd /your/working/directory/

mkdir -p annotations

zcat crp_annot.gz | awk '{if ($1~/^\#./ || $4=="1401") print $0 }' | gzip > annotations/crp_refseq_annot.txt.gz
zcat crp_annot.gz | awk '{if ($1~/^\#./ || $4=="ENSG00000132693") print $0 }' | gzip > annotations/crp_ensembl_annot.txt.gz

cd annotations

mkdir -p refseq
mkdir -p ensembl

for r in refseq ensembl
do
  #loftee
  zcat crp_${r}_annot.txt.gz | awk '/LoF=HC/' | gzip > ${r}/loftee_high_confidence.txt.gz
  zcat crp_${r}_annot.txt.gz | awk '/LoF=LC/' | gzip > ${r}/loftee_low_confidence.txt.gz
  
  #ensembl high impact
  zcat crp_${r}_annot.txt.gz | awk '/IMPACT=HIGH/' | gzip > ${r}/ensembl_high_impact.txt.gz
  
  #cadd
  zcat crp_${r}_annot.txt.gz | awk '/CADD_phred=[1-9][0-9].*;/' > ${r}/cadd_10.txt.gz
  zcat crp_${r}_annot.txt.gz | awk '/CADD_phred=[2-9][0-9].*;/' > ${r}/cadd_20.txt.gz
  
  #sift 
  zcat crp_${r}_annot.txt.gz | awk '/SIFT=deleterious/' > ${r}/sift_deleterious.txt.gz
  
  #lrt
  zcat crp_${r}_annot.txt.gz | awk '/LRT_pred=D/' > ${r}/lrt_deleterious.txt.gz
  
  #mutation taster
  zcat crp_${r}_annot.txt.gz | awk '/MutationTaster_pred=[\.A-Z,]*[AD]+[\.A-Z,]*;/' > ${r}/mutation_taster_deleterious.txt.gz
  
  #polyphen hdiv
  zcat crp_${r}_annot.txt.gz | awk '/Polyphen2_HDIV_pred=[\.A-Z,]*[D]+[\.A-Z,]*;/' > ${r}/polyphen_hdiv_probably_damaging.txt.gz
  
  #polyphen hvar
  zcat crp_${r}_annot.txt.gz | awk '/Polyphen2_HVAR_pred=[\.A-Z,]*[D]+[\.A-Z,]*;/' > ${r}/polyphen_hvar_probably_damaging.txt.gz
done

