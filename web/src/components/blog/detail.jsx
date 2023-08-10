import React, { useState, useEffect } from 'react';
import { useParams } from "react-router-dom";
import { Link } from "react-router-dom";
import 'bootstrap/dist/css/bootstrap.min.css';
import '../../assets/css/style.css'
import axios from 'axios';

function Blog_detail() {
    const { id } = useParams();
  const [disease, setDisease] = useState(null);

  useEffect(() => {
    axios.get(`http://localhost:5090/api/danhsachbenhweb/${id}`)
      .then((response) => {
        setDisease(response.data);
      })
      .catch((error) => {
        console.error('Error fetching disease details:', error);
      });
  }, [id]);

  if (!disease) {
    return <div>Loading...</div>;
  }
    return (
        <div>
            <section className="wrapper bg-light">
                <div className="container py-4 py-md-6">
                    <div className="row gx-lg-8 gx-xl-5">
                        <div className="col-lg-8">
                            <div className="blog">
                                <article className="post">
                                    <div className="card">
                                        <img className="img-responsive" src={disease.imageUrl} alt='' />
                                        <div className="card-body">
                                            <div className="post-heade ">
                                                <div className="post-category text-line code-xxl-6">Teamwork</div>
                                            </div>
                                            <br />
                                            <div className="post-content">
                                                <h2 className="post-title mt-1 mb-0">{disease.tenbenh}</h2>
                                                <div dangerouslySetInnerHTML={{ __html: (disease.noidung) }} />
                                            </div>
                                        </div>
                                    </div>
                                </article>
                            </div>
                        </div>
                    </div></div>
            </section>
        </div>
    )
}

export default Blog_detail
