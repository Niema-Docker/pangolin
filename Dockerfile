# Minimal Docker image for Pangolin v3.1.7 (no UShER) using Minimap2 v2.21 base
FROM niemasd/minimap2:2.21
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>

# install Pangolin (see: https://github.com/cov-lineages/pangolin/blob/master/environment.yml)
RUN apk update && \
    apk add build-base bzip2-dev gfortran git go lapack-dev libgfortran linux-headers py3-pip python3-dev xz-dev && \
    pip install --no-cache-dir 'biopython' 'joblib' 'pandas' 'PuLP' 'pysam' 'scikit-learn' 'snakemake' 'wheel' 'git+https://github.com/cov-lineages/pangoLEARN.git' 'git+https://github.com/cov-lineages/scorpio.git' 'git+https://github.com/cov-lineages/constellations.git' 'git+https://github.com/cov-lineages/pango-designation.git' && \
    wget -qO- "https://github.com/cov-ert/gofasta/archive/refs/tags/v0.0.5.tar.gz" | tar -zx && \
    cd gofasta-* && \
    go build && \
    mv gofasta /usr/local/bin/gofasta && \
    cd .. && \
    pip install --no-cache-dir 'git+https://github.com/cov-lineages/pangolin.git@v3.1.7' && \
    rm -rf gofasta-*
