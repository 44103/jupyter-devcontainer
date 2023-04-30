FROM pytorch/pytorch:latest

RUN export DEBIAN_FRONTEND="noninteractive" && \
  apt-get update && apt-get -y install --no-install-recommends \
  git \
  zsh \
  vim \
  curl ca-certificates && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install required libraries
RUN conda config --add channels pytorch \
  && conda config --append channels conda-forge \
  && conda update --all --yes --quiet \
  && conda install --yes --quiet \
  ipywidgets \
  jupyterlab \
  matplotlib \
  nodejs \
  opencv \
  pandas \
  scikit-learn \
  seaborn \
  sympy \
  && conda clean --all -f -y

# Install jupyter extensions
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension \
  && jupyter labextension install @jupyter-widgets/jupyterlab-manager

ENV TZ=Asia/Tokyo
RUN zsh -c "$(curl -L raw.github.com/44103/dotfiles/main/install.sh)"

