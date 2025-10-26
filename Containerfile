FROM kalilinux/kali-rolling

COPY packages.txt .
RUN apt-get update && xargs apt-get -y install < packages.txt

WORKDIR /workdir

CMD ["/bin/bash"]
