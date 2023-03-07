version 1.0

workflow crp_fetch {
    input {
        File vcf_file
        File index_file
        File ref_genome         #GRCh38_full_analysis_set_plus_decoy_hla.fa.gz
        File ref_genome_index   #GRCh38_full_analysis_set_plus_decoy_hla.fa.gz.fai
        File ref_genome_gzi     #GRCh38_full_analysis_set_plus_decoy_hla.fa.gz.gzi
    }

    call vcf_munging { 
        input: vcf_file = vcf_file, index_file = index_file, ref_genome = ref_genome, ref_genome_index = ref_genome_index, ref_genome_gzi = ref_genome_gzi
    }

    output {
        File hla_out = vcf_munging.mhc_vcf
    }
  
}


task vcf_munging {
    
    input {
        File vcf_file
        File index_file
        File ref_genome
        File ref_genome_index
        File ref_genome_gzi
    }

    command <<<
        bcftools filter --regions chr1:159612289-159814589 ~{vcf_file} -Ou | \
            bcftools view -f 'FILTER=PASS' -Ou | \
            bcftools norm -m -any --check-ref w -f ~{ref_genome} -Ou | \
            bcftools plugin fill-tags -Ou | \
            bcftools view --max-af 0.01:minor -Ou | \
            bcftools annotate --set-id '%CHROM:%POS:%REF:%FIRST_ALT' -Oz > ukb_wgs_mhc.vcf.gz
    >>>

    runtime {
        docker: "monsieurbl/bcftools"
        dx_instance_type: "mem1_ssd1_v2_x8"
    }

    output {
        File mhc_vcf = "ukb_wgs_mhc.vcf.gz"
    }

}
