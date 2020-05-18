
document.addEventListener('turbolinks:load', () => {
    // delegate events to pagination elements
    document.body.addEventListener('click', (e) => {
        const { target } = e;
        
        if (target.matches('.pagination a')) {
            const paginationEl = target.closest('.pagination');
            
            // paginationEl.textContent = 'Page is loading, please wait...';
            
            $.get(target.href, null, null, 'script');
            
            // e.preventDefault();
            return false;
        }
    });
});