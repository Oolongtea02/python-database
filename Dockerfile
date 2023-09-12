FROM python:3-alpine

ENV MAKEFLAGS="-j$(nproc)"

WORKDIR /usr/local/sz-py-db

COPY . /usr/local/sz-py-db

# build dependencies
RUN apk add --no-cache --virtual .build-deps build-base \
    && pip install --no-cache-dir -r requirements.txt \
    && apk del .build-deps

# install required packages/scripts
RUN apk add --no-cache libpq openssl jq curl
#RUN wget -O /usr/local/bin/wait-for https://raw.githubusercontent.com/eficode/wait-for/master/wait-for \
#     && chmod +x /usr/local/bin/wait-for

#RUN openssl req -nodes -x509 -newkey rsa:2048 -keyout /etc/ssl/private/selfsigned.key -out /etc/ssl/certs/selfsigned.crt \
#    -outform PEM -days 7200 -subj "/CN=sre_reports/C=US/ST=WA/L=Somewhere City/O=Self-Signed Inc."

#RUN adduser -u 978 -h /opt/sre_reports -g 'python app user' -s /sbin/nologin -D python
#    # && chown -R python:python /opt/sre_reports

#EXPOSE 8080

# USER python

CMD ["/usr/local/sz-py-db/start.sh"]

