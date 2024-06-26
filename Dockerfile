FROM loopbackkr/pytorch:2.2.2-cuda12.1-cudnn8-devel

ARG USER
ARG XDG_RUNTIME_DIR
RUN groupadd --gid $(basename $XDG_RUNTIME_DIR) $USER &&\
useradd --uid $(basename $XDG_RUNTIME_DIR) --gid $(basename $XDG_RUNTIME_DIR) -m $USER &&\
echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER && chmod 0440 /etc/sudoers.d/$USER

WORKDIR /workspace
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN chown $USER:$USER /workspace
USER $USER
ENV PYTHONPATH=/workspace
ENV PYTHONDONTWRITEBYTECODE 1
