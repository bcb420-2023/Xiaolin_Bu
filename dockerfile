ADD file:29c72d5be8c977acaeb6391aeb23ec27559b594e25a0bb3a6dd280bac2847b7f in /
CMD ["bash"]
LABEL org.opencontainers.image.licenses=GPL-2.0-or-later org.opencontainers.image.source=https://github.com/rocker-org/rocker-versioned2 org.opencontainers.image.vendor=Rocker Project org.opencontainers.image.authors=Carl Boettiger <cboettig@ropensci.org> 0B buildkit.dockerfile.v0
ENV R_VERSION=4.2.2 0B buildkit.dockerfile.v0
ENV R_HOME=/usr/local/lib/R 0B buildkit.dockerfile.v0
ENV TZ=Etc/UTC 0B buildkit.dockerfile.v0
COPY scripts/install_R_source.sh /rocker_scripts/install_R_source.sh # buildkit 3.88kB buildkit.dockerfile.v0
RUN /bin/sh -c /rocker_scripts/install_R_source.sh # buildkit 649MB buildkit.dockerfile.v0
ENV CRAN=https://packagemanager.rstudio.com/cran/__linux__/jammy/latest 0B buildkit.dockerfile.v0
ENV LANG=en_US.UTF-8 0B buildkit.dockerfile.v0
COPY scripts /rocker_scripts # buildkit 66.8kB buildkit.dockerfile.v0
RUN /bin/sh -c /rocker_scripts/setup_R.sh # buildkit 109MB buildkit.dockerfile.v0
CMD ["R"] 0B buildkit.dockerfile.v0
LABEL org.opencontainers.image.licenses=GPL-2.0-or-later org.opencontainers.image.source=https://github.com/rocker-org/rocker-versioned2 org.opencontainers.image.vendor=Rocker Project org.opencontainers.image.authors=Carl Boettiger <cboettig@ropensci.org> 0B buildkit.dockerfile.v0
ENV S6_VERSION=v2.1.0.2 0B buildkit.dockerfile.v0
ENV RSTUDIO_VERSION=2022.07.2+576 0B buildkit.dockerfile.v0
ENV DEFAULT_USER=rstudio 0B buildkit.dockerfile.v0
ENV PANDOC_VERSION=default 0B buildkit.dockerfile.v0
ENV QUARTO_VERSION=default 0B buildkit.dockerfile.v0
RUN /bin/sh -c /rocker_scripts/install_rstudio.sh # buildkit 953MB buildkit.dockerfile.v0
RUN /bin/sh -c /rocker_scripts/install_pandoc.sh # buildkit 96.5kB buildkit.dockerfile.v0
RUN /bin/sh -c /rocker_scripts/install_quarto.sh # buildkit 319kB buildkit.dockerfile.v0
EXPOSE map[8787/tcp:{}] 0B buildkit.dockerfile.v0
CMD ["/init"] 0B buildkit.dockerfile.v0
ARG BIOCONDUCTOR_VERSION=3.16 0B buildkit.dockerfile.v0
ARG BIOCONDUCTOR_PATCH=31 0B buildkit.dockerfile.v0
ARG BIOCONDUCTOR_DOCKER_VERSION=3.16.31 0B buildkit.dockerfile.v0
LABEL name=bioconductor/bioconductor_docker version=3.16.31 url=https://github.com/Bioconductor/bioconductor_docker vendor=Bioconductor Project maintainer=maintainer@bioconductor.org description=Bioconductor docker image with system dependencies to install all packages. license=Artistic-2.0 0B buildkit.dockerfile.v0
ENV BIOCONDUCTOR_USE_CONTAINER_REPOSITORY=FALSE 0B buildkit.dockerfile.v0
ADD bioc_scripts/install_bioc_sysdeps.sh /tmp/ # buildkit 2.77kB buildkit.dockerfile.v0
RUN |3 BIOCONDUCTOR_VERSION=3.16 BIOCONDUCTOR_PATCH=31 BIOCONDUCTOR_DOCKER_VERSION=3.16.31 /bin/sh -c bash /tmp/install_bioc_sysdeps.sh # buildkit 2.22GB buildkit.dockerfile.v0
RUN |3 BIOCONDUCTOR_VERSION=3.16 BIOCONDUCTOR_PATCH=31 BIOCONDUCTOR_DOCKER_VERSION=3.16.31 /bin/sh -c echo "R_LIBS=/usr/local/lib/R/host-site-library:\${R_LIBS}" > /usr/local/lib/R/etc/Renviron.site # buildkit 52B buildkit.dockerfile.v0
ADD bioc_scripts/install.R /tmp/ # buildkit 165B buildkit.dockerfile.v0
RUN |3 BIOCONDUCTOR_VERSION=3.16 BIOCONDUCTOR_PATCH=31 BIOCONDUCTOR_DOCKER_VERSION=3.16.31 /bin/sh -c R -f /tmp/install.R # buildkit 173MB buildkit.dockerfile.v0
RUN |3 BIOCONDUCTOR_VERSION=3.16 BIOCONDUCTOR_PATCH=31 BIOCONDUCTOR_DOCKER_VERSION=3.16.31 /bin/sh -c curl -O http://bioconductor.org/checkResults/devel/bioc-LATEST/Renviron.bioc
   &&  sed -i '/^IS_BIOC_BUILD_MACHINE/d' Renviron.bioc
   &&  cat Renviron.bioc | grep -o '^[^#]*' | sed 's/export //g' >>/etc/environment
   &&  cat Renviron.bioc >> /usr/local/lib/R/etc/Renviron.site
   &&  echo BIOCONDUCTOR_VERSION=${BIOCONDUCTOR_VERSION} >> /usr/local/lib/R/etc/Renviron.site
   &&  echo BIOCONDUCTOR_DOCKER_VERSION=${BIOCONDUCTOR_DOCKER_VERSION} >> /usr/local/lib/R/etc/Renviron.site
   &&  echo 'LIBSBML_CFLAGS="-I/usr/include"' >> /usr/local/lib/R/etc/Renviron.site
   &&  echo 'LIBSBML_LIBS="-lsbml"' >> /usr/local/lib/R/etc/Renviron.site
   &&  rm -rf Renviron.bioc # buildkit 2.89kB buildkit.dockerfile.v0
ENV LIBSBML_CFLAGS=-I/usr/include 0B buildkit.dockerfile.v0
ENV LIBSBML_LIBS=-lsbml 0B buildkit.dockerfile.v0
ENV BIOCONDUCTOR_DOCKER_VERSION=3.16.31 0B buildkit.dockerfile.v0
ENV BIOCONDUCTOR_VERSION=3.16 0B buildkit.dockerfile.v0
ENV BIOCONDUCTOR_USE_CONTAINER_REPOSITORY=TRUE 0B buildkit.dockerfile.v0
CMD ["/init"] 0B buildkit.dockerfile.v0
RUN /bin/sh -c install2.r -d TRUE -r "https://cran.rstudio.com" RColorBrewer ggplot2 devtools rmarkdown httr knitr xaringan bookdown gprofiler2 # buildkit 334MB buildkit.dockerfile.v0
RUN /bin/sh -c R -e 'BiocManager::install(c("GEOQuery","ComplexHeatmap","biomaRt","GEOmetadb","limma","edgeR","BiocGenerics"))' # buildkit 120MB buildkit.dockerfile.v0
RUN /bin/sh -c R -e 'BiocManager::install(c("kableExtra","GSEABase","GSVA","BiocStyle","fgsea", "BiocParallel"))' # buildkit 295MB buildkit.dockerfile.v0
RUN /bin/sh -c R -e 'BiocManager::install(c("RCy3","GSA", "seurat"))' # buildkit 24.8MB buildkit.dockerfile.v0
/bin/bash 21.6MB R env for Xiaolin_Bu
