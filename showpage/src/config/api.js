// API配置文件
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8090/api';

export const API = {
  // 用户相关
  LOGIN: `${API_BASE_URL}/login`,
  REGISTER: `${API_BASE_URL}/register`,
  
  // 货物相关
  GOODS: {
    LIST: `${API_BASE_URL}/goods/list`,
    CREATE: `${API_BASE_URL}/goods/create`,
    UPDATE: (id) => `${API_BASE_URL}/goods/update/${id}`,
    DELETE: (id) => `${API_BASE_URL}/goods/delete/${id}`,
    OUT: (id) => `${API_BASE_URL}/goods/out/${id}`,
  },
  
  // 其他API端点...
};

export default API; 