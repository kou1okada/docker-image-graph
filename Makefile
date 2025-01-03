PORT=3000
PNG=image_graph.png
NAME=image-graph

.build: stop Dockerfile image-graph-cmd.rb image-graph-web.rb image-graph.sh public/index.html public/texture-noise.png
	docker build -t $(NAME) .
	touch .build

build: .build

png: build
	@docker run --rm -v /var/run/docker.sock:/var/run/docker.sock --name $(NAME) -h $(NAME) $(NAME) > $(PNG)
	xdg-open $(PNG)

start: build stop
	docker run -d --rm -v /var/run/docker.sock:/var/run/docker.sock -e PORT=3000 -p $(PORT):3000 --name $(NAME) -h $(NAME) $(NAME)
	xdg-open http://localhost:$(PORT)

stop:
	-docker stop -t 0 $(NAME)

clean: stop
	-docker rmi $(NAME)
	-$(RM) $(PNG)
