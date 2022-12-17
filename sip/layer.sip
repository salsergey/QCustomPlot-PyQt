/** PyQt5 binding for QCustomPlot v2.1.1
 *  
 *  Authors: Dmitry Voronin, Giuseppe Corbelli
 *  License: MIT
 *  
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPLayer : public QObject
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  enum LayerMode { lmLogical   ///< Layer is used only for rendering order, and shares paint buffer with all other adjacent logical layers.
                   ,lmBuffered ///< Layer has its own paint buffer and may be replotted individually (see \ref replot).
                 };
  
  QCPLayer(QCustomPlot *parentPlot /TransferThis/, const QString &layerName);
  virtual ~QCPLayer();
  
  // getters:
  QCustomPlot *parentPlot() const;
  QString name() const;
  int index() const;
  QList<QCPLayerable*> children() const;
  bool visible() const; 
  LayerMode mode() const;
  
  // setters:
  void setVisible(bool visible);
  void setMode(LayerMode mode);
  
  // non-virtual methods:
  void replot();

protected:
  // non-virtual methods:
  void draw(QCPPainter *painter);
  void drawToPaintBuffer();
  void addChild(QCPLayerable *layerable, bool prepend);
  void removeChild(QCPLayerable *layerable);
};

class QCPLayerable : public QObject /Abstract/
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  QCPLayerable(QCustomPlot *plot /TransferThis/, QString targetLayer=QString(), QCPLayerable *parentLayerable=0);
  virtual ~QCPLayerable();
  
  // getters:
  bool visible() const; 
  QCustomPlot *parentPlot() const;
  QCPLayerable *parentLayerable() const;
  QCPLayer *layer() const;
  bool antialiased() const;
  
  // setters:
  void setVisible(bool on);
  Q_SLOT bool setLayer(QCPLayer *layer);
  bool setLayer(const QString &layerName);
  void setAntialiased(bool enabled);
  
  // introduced virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;

  // non-property methods:
  bool realVisibility() const;
  
signals:
  void layerChanged(QCPLayer *newLayer);

protected:
  // introduced virtual methods:
  virtual void parentPlotInitialized(QCustomPlot *parentPlot);
  virtual QCP::Interaction selectionCategory() const;
  virtual QRect clipRect() const;
  virtual void applyDefaultAntialiasingHint(QCPPainter *painter) const = 0;
  virtual void draw(QCPPainter *painter) = 0;
  // selection events:
  virtual void selectEvent(QMouseEvent *event, bool additive, const QVariant &details, bool *selectionStateChanged);
  virtual void deselectEvent(bool *selectionStateChanged);
  // low-level mouse events:
  virtual void mousePressEvent(QMouseEvent *event, const QVariant &details);
  virtual void mouseMoveEvent(QMouseEvent *event, const QPointF &startPos);
  virtual void mouseReleaseEvent(QMouseEvent *event, const QPointF &startPos);
  virtual void mouseDoubleClickEvent(QMouseEvent *event, const QVariant &details);
  virtual void wheelEvent(QWheelEvent *event);

  // non-property methods:
  void initializeParentPlot(QCustomPlot *parentPlot);
  void setParentLayerable(QCPLayerable *parentLayerable);
  bool moveToLayer(QCPLayer *layer, bool prepend);
  void applyAntialiasingHint(QCPPainter *painter, bool localAntialiased, QCP::AntialiasedElement overrideElement) const;
};
 
