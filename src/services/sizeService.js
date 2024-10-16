import axios from "../setup/axios"; // an instance of axios

const fetchAllSizesService = () => {
    return axios({
        method: 'get',
        url: `/api/v1/public/sizes/all`,
    });
}

export {
    fetchAllSizesService,

}
