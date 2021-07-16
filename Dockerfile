# Minimal Docker image for Pangolin v3.1.7 (no UShER) using Minimap2 v2.21 base
FROM niemasd/minimap2:2.21
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>

# install Pangolin (see: https://github.com/cov-lineages/pangolin/blob/master/environment.yml)
RUN apk update && \
    apk add build-base bzip2-dev gfortran git go lapack-dev libgfortran linux-headers py3-pandas py3-pip py3-scikit-learn python3-dev xz-dev && \
    pip install --no-cache-dir 'wheel' && \
    # PuLP doesn't work (need to fix)
    pip install --no-cache-dir 'biopython' 'joblib' 'PuLP' 'pysam' 'snakemake' && \
    pip install --no-cache-dir 'git+https://github.com/cov-lineages/scorpio.git' && \
    pip install --no-cache-dir 'git+https://github.com/cov-lineages/constellations.git' && \
    pip install --no-cache-dir 'git+https://github.com/cov-lineages/pango-designation.git' && \
    pip install --no-cache-dir 'git+https://github.com/cov-lineages/pangoLEARN.git' && \
    wget -qO- "https://github.com/cov-ert/gofasta/archive/refs/tags/v0.0.5.tar.gz" | tar -zx && \
    cd gofasta-* && \
    go build && \
    mv gofasta /usr/local/bin/gofasta && \
    cd .. && \
    pip install --no-cache-dir 'git+https://github.com/cov-lineages/pangolin.git@v3.1.7' && \
    # disable UShER check (for now)
    sed -i 's/,"usher"]/]#,"usher"]/g' /usr/lib/python*/site-packages/pangolin/utils/dependency_checks.py && \
    rm -rf gofasta-*
