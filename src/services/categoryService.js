import axios from "../setup/axios"; // an instance of axios

const fetchAllCategoriesService = () => {
    return axios({
        method: 'get',
        url: `/api/v1/public/categories/all`,
    });
}

export {
    fetchAllCategoriesService,

}
