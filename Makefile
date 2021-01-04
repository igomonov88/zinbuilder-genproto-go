all: gateway format

gateway:
	protoc \
	-I ${API_COMMON_PROTOS} \
	-I ${APIS} \
    --go_out=. \
    --go_opt=module=${GENPROTO_GO_MODULE} \
    --grpc-gateway_opt=module=${GENPROTO_GO_MODULE} \
	--grpc-gateway_out=. \
	--go-grpc_out=. \
    --go-grpc_opt=module=${GENPROTO_GO_MODULE} \
	${APIS}/ms-gateway/v1/*.proto

DIRS = $$(go list -f {{.Dir}} ./...)

format:
	for d in $(DIRS); do goimports -w $$d/*.go; done