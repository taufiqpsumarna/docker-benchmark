#!/bin/bash
docker-compose down 
docker-compose up -d --no-cache --build && docker-compose logs -f
