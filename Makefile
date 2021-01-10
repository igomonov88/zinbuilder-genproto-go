all: gateway ratelimiter format

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
    --go-grpc_opt=require_unimplemented_servers=false \
	${APIS}/ms-gateway/v1/*.proto

DIRS = $$(go list -f {{.Dir}} ./...)

ratelimiter:
	protoc \
	-I ${API_COMMON_PROTOS} \
	-I ${APIS} \
    --go_out=. \
    --go_opt=module=${GENPROTO_GO_MODULE} \
    --grpc-gateway_opt=module=${GENPROTO_GO_MODULE} \
	--grpc-gateway_out=. \
	--go-grpc_out=. \
    --go-grpc_opt=module=${GENPROTO_GO_MODULE} \
    --go-grpc_opt=require_unimplemented_servers=false \
	${APIS}/ms-rate-limiter/v1/*.proto

DIRS = $$(go list -f {{.Dir}} ./...)

format:
	for d in $(DIRS); do goimports -w $$d/*.go; done